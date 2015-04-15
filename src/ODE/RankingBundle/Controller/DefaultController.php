<?php

namespace ODE\RankingBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends Controller
{
    public function indexAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $datasets = $em->getRepository('ODEDatasetBundle:Dataset')->findAll();
        return $this->render('ODERankingBundle:Default:index.html.twig', array(
            'datasets' => $datasets
        ));
    }

    public function getTableDataAction(Request $request)
    {
        $dataset_id = $request->query->get('dataset_id');
        $fields = array('r.username', 'r.model', 'r.accuracy', 'r.auroc', 'r.aupr', 'r.runtime');

        $repository = $this->getDoctrine()->getRepository('ODEAnalysisBundle:Result');
        $query = $repository->createQueryBuilder('r')
            ->select($fields)
            ->where('r.dataset = :dataset')
            ->setParameter('dataset', $dataset_id)
            ->getQuery();

        //$query->setMaxResults(10);
        $results = $query->getResult();

        $data = array();
        foreach ($results as $result){
            array_push($data,array_values($result));
        }
        return new Response(json_encode(array('data'=>$data)));
    }
}
