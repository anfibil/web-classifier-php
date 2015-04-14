<?php

namespace ODE\RankingBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('ODERankingBundle:Default:index.html.twig', array('name' => 'name'));
    }
}
