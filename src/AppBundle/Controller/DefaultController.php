<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('default/index.html.twig');
    }

    public function helloAction($name)
    {
        // Added comment
        return $this->render('default/hello.html.twig',array('name' => $name));
    }
}
