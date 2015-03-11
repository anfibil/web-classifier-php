<?php

namespace ODE\UserBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
//use ODE\UserBundle\Form\Type\RegistrationFormType;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('ODEUserBundle:Default:index.html.twig', array('username' => $this->getUser()));
    }

    public function uploadProfilePictureAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $user = $this->getUser();

        $pic = $request->files->get("profilePictureFile");

        $user->setProfilePictureFile($pic);
        $user->upload();
        $em->persist($user);
        $em->flush();

        return new JsonResponse(array(
            'status'=>'success'
        ));
    }
}
