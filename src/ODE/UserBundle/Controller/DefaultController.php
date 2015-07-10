<?php

namespace ODE\UserBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

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

    public function getUserInfoAction(Request $request){
        $user_id = $request->query->get('user_id');
        $repository = $this->getDoctrine()->getRepository('ODEAnalysisBundle:Result');

        $n_analysis = $repository->createQueryBuilder('r')
            ->select('COUNT(r.id)')
            ->where('r.user = :user_id')
            ->setParameter('user_id', $user_id)
            ->getQuery()
            ->getSingleScalarResult();

        $avg_auroc = $repository->createQueryBuilder('r')
            ->select('AVG(r.auroc)')
            ->where('r.user = :user_id')
            ->setParameter('user_id', $user_id)
            ->getQuery()
            ->getSingleScalarResult();

        $avg_aupr = $repository->createQueryBuilder('r')
            ->select('AVG(r.aupr)')
            ->where('r.user = :user_id')
            ->setParameter('user_id', $user_id)
            ->getQuery()
            ->getSingleScalarResult();

        $total_runtime = $repository->createQueryBuilder('r')
            ->select('SUM(r.runtime)')
            ->where('r.user = :user_id')
            ->setParameter('user_id', $user_id)
            ->getQuery()
            ->getSingleScalarResult();

        return new Response(json_encode(array('n_analysis'=>$n_analysis,'avg_auroc'=>$avg_auroc,'avg_aupr'=>$avg_aupr, 'total_runtime'=>$total_runtime)));

    }
}
