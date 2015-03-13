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

    public function configAnalysisAction(Request $request){
        $username = $this->getUser()->getUsername();

        $result = new Result();
        $result->setusername($username);

        $form = $this->createFormBuilder($result)
            ->add('algorithm','choice',array(
                'choices' => array(
                    'rf' => 'Random Forest',
                    'lg' => 'Logistic Regression'),
                'required' => true,))
            ->add('save' , 'submit' , array('label' => 'Run Analysis' ))
            ->getForm();

        $form->handleRequest($request);
        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($result);
            $em->flush();
            $this->runAnalysis($result->getId());

            //TODO: Supress the ?id= from URL somehow
            return $this->redirect($this->generateUrl('ode_analysis_run', array('id' => $result->getId()),true));
        }

        return $this->render('ODEAnalysisBundle:Default:index.html.twig',array(
            'form' => $form->createView(),
        ));
    }

    private function runAnalysis($id){
        $script = __DIR__.'/../../../../web/assets/scripts/run_analysis.py';

        // To prevent blocking, use the code below when running the python script
        // Note that windows doesn't like '&' so we use pclose() for the time being
        // TODO: Edit this code when deploying to production server
        if (substr(php_uname(), 0, 7) == "Windows"){
            $terminal_output = pclose(popen('start /B python '.$script.' '.$id, "r"));
        }
        else {
            $terminal_output = exec('python '.$script.' '.$id.' &');
        }
    }
    public function runAnalysisAction(Request $request){
        return $this->render('ODEAnalysisBundle:Default:result.html.twig', array('id' => $request->query->get('id')));
    }


    public function checkIfAnalysisIsDoneAction(Request $request){
        $analysis_id = $request->query->get('id');
        $em = $this->getDoctrine()->getManager();
        $analysis = $em->getRepository('ODEAnalysisBundle:Result')->find($analysis_id);

        // If database has value of '1' on 'finished' column ...
        if($analysis->getFinished()){
            // Pass content of 'result' json stored in the database to generateOutput()
            // That function will generate the appropriate html output
            $report = array('html'=> $this->generateOutput($analysis->getResult()) ,'finished'=>1);

            return new Response(json_encode((object)$report));
        }

        return new Response(json_encode(array('result'=> 'still running' ,'finished'=>0)));
    }

    public function generateOutput($results){
        $output = '
            <div class="col-lg-8 col-lg-offset-2">
                <table class="table table-striped table-bordered table-hover dataTables-example" >
                    <thead>
                    <tr>
                        <th class="text-center">AUROC</th>
                        <th class="text-center">Accuracy</th>
                        <th class="text-center">Precision</th>
                        <th class="text-center">Recall</th>
                        <th class="text-center">F-measure</th>
                        <th class="text-center">RMSE</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <td>'.$results['auroc'].'</td>
                        <td>'.$results['accuracy'].'</td>
                        <td>'.$results['precision'].'</td>
                        <td>'.$results['recall'].'</td>
                        <td>'.$results['fmeasure'].'</td>
                        <td>'.$results['rmse'].'</td>
                    </tr>
                    </tfoot>
                </table>
            </div>';
        return $output;
    }
}
