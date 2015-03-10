<?php

namespace ODE\DatasetBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('ODEDatasetBundle:Default:index.html.twig');
    }
}
