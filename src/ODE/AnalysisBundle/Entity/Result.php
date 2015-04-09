<?php

namespace ODE\AnalysisBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Result
 *
 * @ORM\Table(name="ode_results")
 * @ORM\Entity
 */
class Result
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var integer
     *
     * @ORM\Column(name="model", type="integer", length=255)
     */
    private $model;

    /**
     * @var array
     *
     * @ORM\Column(name="params", type="json_array", nullable=true)
     */
    private $params;

    /**
     * @var float
     *
     * @ORM\Column(name="runtime", type="float", nullable=true)
     */
    private $runtime;

    /**
     * @var boolean
     *
     * @ORM\Column(name="finished", type="boolean")
     */
    private $finished;

    /**
     * @var string
     *
     * @ORM\Column(name="username", type="string", length=255)
     */
    private $username;

    /**
     * @var integer
     *
     * @ORM\Column(name="dataset", type="integer")
     */
    private $dataset;

    /**
     * @var string
     *
     * @ORM\Column(name="dataset_name", type="string", length=255, nullable=true)
     */
    private $dataset_name;

    /**
     * @var array
     *
     * @ORM\Column(name="result", type="json_array", nullable=true)
     */
    private $result;

    function __construct()
    {
        $this->finished = false;
        $this->dataset = 1; // Replace this with dataset ID from form selection later
    }

    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set algorithm
     *
     * @param integer $model
     * @return Result
     */
    public function setModel($model)
    {
        $this->model = $model;

        return $this;
    }

    /**
     * Get model
     *
     * @return integer
     */
    public function getModel()
    {
        return $this->model;
    }

    /**
     * Set parameters
     *
     * @param array $params
     * @return Result
     */
    public function setParams($params)
    {
        $this->params = $params;

        return $this;
    }

    /**
     * Get parameters
     *
     * @return array 
     */
    public function getParams()
    {
        return $this->params;
    }

    /**
     * Set runtime
     *
     * @param float $runtime
     * @return Result
     */
    public function setRuntime($runtime)
    {
        $this->runtime = $runtime;

        return $this;
    }

    /**
     * Get runtime
     *
     * @return float
     */
    public function getRuntime()
    {
        return $this->runtime;
    }

    /**
     * Set finished
     *
     * @param boolean $finished
     * @return Result
     */
    public function setFinished($finished)
    {
        $this->finished = $finished;

        return $this;
    }

    /**
     * Get finished
     *
     * @return boolean 
     */
    public function getFinished()
    {
        return $this->finished;
    }

    /**
     * Set username
     *
     * @param string $username
     * @return Result
     */
    public function setUsername($username)
    {
        $this->username = $username;

        return $this;
    }

    /**
     * Get username
     *
     * @return string 
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * Set dataset
     *
     * @param integer $dataset
     * @return Result
     */
    public function setDataset($dataset)
    {
        $this->dataset = $dataset;

        return $this;
    }

    /**
     * Get dataset
     *
     * @return integer
     */
    public function getDataset()
    {
        return $this->dataset;
    }

    /**
     * Set username
     *
     * @param string $dataset_name
     * @return Result
     */
    public function setDataset_name($dataset_name)
    {
        $this->dataset_name = $dataset_name;

        return $this;
    }

    /**
     * Get username
     *
     * @return string
     */
    public function getDataset_name()
    {
        return $this->dataset_name;
    }

    /**
     * Set result
     *
     * @param array $result
     * @return Result
     */
    public function setResult($result)
    {
        $this->result = $result;

        return $this;
    }

    /**
     * Get result
     *
     * @return array 
     */
    public function getResult()
    {
        return $this->result;
    }
}
