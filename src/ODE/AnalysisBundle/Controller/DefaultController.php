<?php

namespace ODE\AnalysisBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('ODEAnalysisBundle:Default:index.html.twig');
    }
}
