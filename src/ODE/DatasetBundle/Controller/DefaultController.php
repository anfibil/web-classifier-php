<?php

namespace ODE\DatasetBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        $datasetRepository = $this->getDoctrine()->getRepository('ODEDatasetBundle:Dataset');
        $datasets = $datasetRepository->getDatasets();
        //dump($datasets);

        return $this->render('ODEDatasetBundle:Default:index.html.twig', array('datasets' => $datasets));
    }
}
