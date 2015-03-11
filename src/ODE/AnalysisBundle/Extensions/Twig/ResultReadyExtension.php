<?php

namespace ODE\AnalysisBundle\Extensions\Twig;
use Symfony\Bridge\Doctrine\RegistryInterface;


class ResultReadyExtension extends \Twig_Extension
{
    protected $doctrine;

    public function __construct(RegistryInterface $doctrine)
    {
        $this->doctrine = $doctrine;
    }

    public function getFunctions()
    {
        return array(
            new \Twig_SimpleFunction('isFinished', array($this, 'isFinished')),
        );
    }


    public function isFinished($id)
    {
        $result = $this->doctrine->getRepository('ODEAnalysisBundle:Result')->find($id);
        if($result->getFinished()){
            var_dump($result->getResult());
            return true;
        }

        return false;

    }

    public function getName()
    {
        return 'isFinished';
    }

}