<?php

namespace ODE\DatasetsBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Dataset
 */
class Dataset
{
    /**
     * @var integer
     */
    private $id;


    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }
}
