<?php

namespace ODE\UserBundle\Controller;

use ODE\UserBundle\Entity\User;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;

class ProfileController extends Controller
{
    public function uploadProfilePictureAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $user = $this->getUser();


        $form = $this->createFormBuilder($user)
            ->add('profilePictureFile')
            ->getForm();

        $form->handleRequest($request);
        if ($form->isValid()) {
            $user->uploadProfilePicture();
            $em->flush();

            return new JsonResponse(
                array(
                    'status' => 'success'
                )
            );
        }

        return new JsonResponse(
            array(
                'status' => 'fail',
                'message' => $form->getErrors(true)
            )
        );
    }
}