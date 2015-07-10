<?php

namespace ODE\DatasetBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\File\UploadedFile;
//use ODE\DatasetBundle\Form\UploadDataset;
//use ODE\DatasetBundle\Entity\Dataset;
use ODE\DatasetBundle\Entity\Dataset;
use ODE\DatasetBundle\Models\Document;

class UploadController extends Controller
{
    public function uploadAction(Request $request)
    {
        $success = false;
        $message = '';

        if($request->getMethod()=='POST') {
            $datafile = $request->files->get('datafile');
            $dataname = $request->get('dataname');
            $datadesc = $request->get('datadesc');

            if (($datafile instanceof UploadedFile) && ($datafile->getError()=='0')) {
                $originalName = $datafile->getClientOriginalName();
                $name_array = explode('.', $originalName);
                $file_type = $name_array[sizeof($name_array)-1];
                $valid_filetypes = array('csv');
                if (in_array(strtolower($file_type), $valid_filetypes)) {
                    $em = $this->getDoctrine()->getManager();

                    // Start uploading dataset.
                    $document = new Document();
                    $document->setFile($datafile);
                    $document->setUploadDirectory('assets' . DIRECTORY_SEPARATOR . 'datasets');
                    if ($document->processFile() == 2) {
                        $success = false;
                        $message = "This file has already been uploaded.";
                    } else {
                        $uploadedURL = $document->getUploadDirectory(
                            ).DIRECTORY_SEPARATOR.$document->getFilePersistencePath();

                        // Get dataset attributes.
                        $num_instances = 0;
                        $num_features = 0;
                        if (strtolower($file_type) == 'csv') {
                            dump('csv');
                            dump($uploadedURL);
                            if (($handle = fopen($uploadedURL, "r")) !== false) {
                                while (($data = fgetcsv($handle, $delimiter = ",")) !== false) {
                                    $num_features = count($data);
                                    $num_instances++;
                                }
                                fclose($handle);
                            }
                        }

                        // Persist dataset entity.
                        $dataset = new Dataset();
                        $dataset->setName($dataname);
                        $dataset->setDescription($datadesc);
                        $dataset->setNumInstances($num_instances);
                        $dataset->setNumFeatures($num_features);
                        $dataset->setFiletype(strtolower($file_type));
                        $dataset->setFilesize($datafile->getClientSize());
                        $dataset->setFilename(implode('', array_slice($name_array, 0, -1)));
                        $dataset->setFile($document->getFile());

                        $em->persist($dataset);
                        $em->flush();

                        $success = true;
                        $message = "Thank you for uploading your file!";
                    }
                    return $this->render('ODEDatasetBundle:Default:upload.html.twig', array('success'=>$success, 'message'=>$message));

                } else {
                    $message = "Invalid file type.";
                }
            }

            return $this->render('ODEDatasetBundle:Default:upload.html.twig', array('success'=>$success, 'message'=>$message));
        } else {
            return $this->render('ODEDatasetBundle:Default:upload.html.twig', array('success'=>$success, 'message'=>$message));
        }
    }
}
