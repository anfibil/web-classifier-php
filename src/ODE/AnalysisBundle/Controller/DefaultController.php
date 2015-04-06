<?php

namespace ODE\AnalysisBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use ODE\AnalysisBundle\Entity\Result;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;


class DefaultController extends Controller
{
    public function indexAction()
    {

        return $this->render('ODEAnalysisBundle:Default:index.html.twig');
    }

    public function runAnalysisAction(Request $request){
        $username = $this->getUser()->getUsername();
        $model = $request->query->get('model');
        $dataset = $request->query->get('dataset');

        // Retrieve all GET parameters and remove from the list some that are going to be saved on a different column in the table
        $params = $request->query->all();
        unset($params['dataset'],$params['model'],$params['acceptTerms']);

        // Retrieve from model table a mapping parameter->parameter_type
        $model_params = $this->getDoctrine()
            ->getRepository('ODEAnalysisBundle:Model')
            ->find($model)->getParameters();

        // Check to see if parameter list is empty (e.g., Naive Bayes)
        // If so, pass an empty object to represent that
        if (!count((array)$params)){
            $params =  (object) null;
        }
        // Convert string values from GET to actual numbers so that python script won't freak out
        else{
            foreach (array_keys($params) as $param){
                if ($model_params[$param] == 'int'){
                    $params[$param] = (int)$params[$param];
                }elseif (($model_params[$param] == 'float')){
                    $params[$param] = (float)$params[$param];
                }elseif (($model_params[$param] == 'bool')){
                    $params[$param] = (int)$params[$param];
                }
            }
        }

        // Create an entry with that data in the ode_results table
        $result = new Result();
        $result->setusername($username);
        $result->setAlgorithm($model);
        $result->setDataset($dataset);
        $result->setParams($params);

        $em = $this->getDoctrine()->getManager();
        $em->persist($result);
        $em->flush();

        // Once all parameters for the experiment are stored, call python script to actually run it
        $this->runAnalysis($result->getId());

        // Once script is called, redirect user to "waiting" page
        return $this->redirect($this->generateUrl('ode_wait_result', array('id' => $result->getId()),true));
    }

    private function runAnalysis($id){
        // Python script needs to know the "current_dir" to open data files
        $script = __DIR__.'/../../../../web/assets/scripts/run_analysis.py';
        $current_dir = __DIR__.'/../../../../web/assets/scripts/';

        // To prevent blocking, use the code below when running the python script
        // Note that windows doesn't like '&' so we use pclose() for the time being
        // TODO: Edit this code when deploying to production server
        if (substr(php_uname(), 0, 7) == "Windows"){
            $terminal_output = pclose(popen('start /B python '.$script.' '.$id.' '.$current_dir, "r"));
        }
        else {
            $terminal_output = exec('python '.$script.' '.$id.' '.$current_dir.' &');
        }
    }
    public function waitForAnalysisResultAction(Request $request){
        return $this->render('@ODEAnalysis/Default/waitResult.html.twig', array('id' => $request->query->get('id')));
    }

    public function checkIfAnalysisIsDoneAction(Request $request){
        $analysis_id = $request->query->get('id');
        $em = $this->getDoctrine()->getManager();
        $analysis = $em->getRepository('ODEAnalysisBundle:Result')->find($analysis_id);

        // Return 0 or 1 from database indicating whether or not analysis finished running
        return new Response(json_encode(array('finished'=>$analysis->getFinished())));
    }

    public function generateReportAction(Request $request){
        $analysis_id = $request->query->get('id');
        $em = $this->getDoctrine()->getManager();
        $analysis = $em->getRepository('ODEAnalysisBundle:Result')->find($analysis_id);

        $result = $analysis->getResult();
        return $this->render('@ODEAnalysis/Default/report.html.twig',
            array(
                'auroc' => $result['auroc'],
                'aupr' => $result['aupr'],
                'roc_points' => $result['roc_points'],
                'prc_points' => $result['prc_points']
            )
        );
    }
}
