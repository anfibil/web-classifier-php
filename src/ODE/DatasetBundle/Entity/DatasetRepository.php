<?php

namespace ODE\DatasetBundle\Entity;
use Doctrine\ORM\EntityRepository;

class DatasetRepository extends EntityRepository
{
    public function getDatasets()
    {
        $query = $this->createQueryBuilder('ds')
            ->orderBy('ds.name', 'ASC')
            ->getQuery();

        return $query->getResult();
    }
}