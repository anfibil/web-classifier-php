<?php

namespace ODE\DatasetBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use ODE\DatasetBundle\Form\UploadDataset;
use ODE\DatasetBundle\Entity\Dataset;

class DefaultController extends Controller
{
    public function indexAction()
    {
        $datasetRepository = $this->getDoctrine()->getRepository('ODEDatasetBundle:Dataset');
        $datasets = $datasetRepository->getDatasets();
        //dump($datasets);

        return $this->render('ODEDatasetBundle:Default:index.html.twig', array('datasets' => $datasets));
    }

    public function uploadAction()
    {
        $task = new Dataset();
        $form = $this->createForm(new UploadDataset(), $task);

        if ($form->isValid()) {

            $nextAction = $form->get('saveAndAdd')->isClicked()
                ? 'task_new'
                : 'task_success';

            return $this->redirectToRoute($nextAction);
        }

        return $this->render('ODEDatasetBundle:Default:upload.html.twig', array(
            'form' => $form->createView(),
        ));
    }
}
