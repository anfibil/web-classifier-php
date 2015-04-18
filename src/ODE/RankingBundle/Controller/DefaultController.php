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
        $fields = array('partial r.{id,user,model,accuracy,auroc,aupr,runtime,date}');
        $repository = $this->getDoctrine()->getRepository('ODEAnalysisBundle:Result');
        $results = $repository->createQueryBuilder('r')
            ->select($fields)
            ->where('r.dataset = :dataset')
            ->orderBy('r.accuracy', 'DESC')
            ->setFirstResult(0)
            ->setMaxResults(1000)   //Get only the top 1000 rows (this will prevent huge queries in future) - see orderBy
            ->setParameter('dataset', $dataset_id)
            ->getQuery()
            ->execute();

        $data = array();
        foreach ($results as $result){
            // Each $result is an object but serialization throws a CircularReferenceException because of foreign keys
            // For now, we are setting each variable that is to be displayed in the table individually
            // Look at http://goo.gl/jEdk6Z for handling instructions. Keep in mind there are 2 foreign keys (model and user)
            $user = (object) array('picture'=> $result->getUser()->getProfilePicturePath(), 'username'=> $result->getUser()->getUsername());
            $model = $result->getModel()->getName();
            $accuracy = $result->getAccuracy();
            $auroc = $result->getAuroc();
            $aupr = $result->getAupr();
            $runtime = $result->getRuntime();
            $date = $result->getDate();
            $id = $result->getId();

            $result = array($user,$model,$accuracy,$auroc,$aupr,$runtime,$date,$id);

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

    public function getTopResultsAction(Request $request)
    {
        $dataset_id = (int) $request->query->get('dataset_id'); // Make sure that the dataset_id is an integer

        $entityManager = $this->getDoctrine()->getManager();

        $accuracy = $entityManager->createQuery(
            'SELECT U.username as username,R.accuracy as top, R.id as result_id FROM ODEAnalysisBundle:Result R JOIN R.user U WHERE R.dataset = :dataset ORDER BY R.accuracy DESC, R.id ASC'
        )->setParameter('dataset', $dataset_id)->setMaxResults(1)->getOneOrNullResult();

        $auroc = $entityManager->createQuery(
            'SELECT U.username as username,R.auroc as top, R.id as result_id FROM ODEAnalysisBundle:Result R JOIN R.user U WHERE R.dataset = :dataset ORDER BY R.auroc DESC, R.id ASC'
        )->setParameter('dataset', $dataset_id)->setMaxResults(1)->getOneOrNullResult();

        $aupr = $entityManager->createQuery(
            'SELECT U.username as username,R.aupr as top, R.id as result_id FROM ODEAnalysisBundle:Result R JOIN R.user U WHERE R.dataset = :dataset ORDER BY R.aupr DESC, R.id ASC'
        )->setParameter('dataset', $dataset_id)->setMaxResults(1)->getOneOrNullResult();

        $runtime = $entityManager->createQuery(
            'SELECT U.username as username,R.runtime as top, R.id as result_id FROM ODEAnalysisBundle:Result R JOIN R.user U WHERE R.dataset = :dataset ORDER BY R.runtime ASC, R.id ASC'
        )->setParameter('dataset', $dataset_id)->setMaxResults(1)->getOneOrNullResult();

        $response = json_encode(array('accuracy' => $accuracy, 'auroc' => $auroc, 'aupr' =>$aupr, 'runtime' =>$runtime));

        return new Response($response);

    }
}
