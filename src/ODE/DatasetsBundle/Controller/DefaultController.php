<?php

namespace ODE\DatasetsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('ODEDatasetsBundle:Default:index.html.twig', array('name' => $name));
    }
}
