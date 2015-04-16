<?php

namespace ODE\RankingBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends Controller
{
    public function indexAction()
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
        $fields = array('r.username', 'r.model_name', 'r.accuracy', 'r.auroc', 'r.aupr', 'r.runtime');

        $repository = $this->getDoctrine()->getRepository('ODEAnalysisBundle:Result');
        $query = $repository->createQueryBuilder('r')
            ->select($fields)
            ->where('r.dataset = :dataset')
            ->orderBy('r.accuracy', 'DESC')
            ->setFirstResult(0)
            ->setMaxResults(1000)   //Get only the top 1000 rows (this will prevent huge queries in future) - see orderBy
            ->setParameter('dataset', $dataset_id)
            ->getQuery();
        $results = $query->getResult();

        $data = array();
        foreach ($results as $result){

            // Try to get user picture (this should be replaced by a left join but we need set the association first)
            $userRepository = $this->getDoctrine()->getRepository('ODEUserBundle:User');
            $userQuery = $userRepository->createQueryBuilder('u')
            ->select(['u.profilePicturePath'])
            ->where('u.username = :uname')
            ->setParameter('uname', $result['username'])
            ->getQuery();
            $userProfilePictureUrl = $userQuery->getSingleScalarResult();

            // Now that we *probably* have the picture, lets turn the user data in an object. This object will be reformatted before display via JS
            $result['username'] = (object) array('picture'=> $userProfilePictureUrl, 'username'=> $result['username']); //Turn the username in a object

            // Remove keys from array to comply with what datatables expects
            $result = array_values($result);
            // Add an empty element at index 0 to help dataTables with fixed rank column
            array_splice($result, 0, 0, '');
            // Round all metrics to 4 decimal places
            array_push($data,array_map(array($this, 'roundNumbers'), $result));
        }

        return new Response(json_encode(array('data'=>$data)));
    }

    private static function roundNumbers($n){
        if (is_float($n)){
            return number_format(round($n,4),4);
        }
        return $n;
    }
}
