<?php

namespace ODE\UserBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class ODEUserBundle extends Bundle
{
    public function getParent()
    {
        return 'FOSUserBundle';
    }
}
