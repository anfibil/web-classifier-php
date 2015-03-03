<?php

namespace ODE\UserBundle\Services\Extension;

use Symfony\Component\DependencyInjection\ContainerInterface;

class ConditionalAssetExtension extends \Twig_Extension
{
    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
    }

    /**
     * Returns a list of functions to add to the existing list.
     *
     * @return array An array of functions
     */
    public function getFunctions()
    {
        return array(
            'asset_if' => new \Twig_Function_Method($this, 'asset_if'),
        );
    }

    /**
     * Get the path to an asset. If it does not exist, return the path to the
     * fallback path.
     *
     * @param string $path the path to the asset to display
     * @param string $fallbackPath the path to the asset to return in case asset $path does not exist
     * @return string path
     */
    public function asset_if($path, $fallbackPath)
    {
        // Define the path to look for
        $pathToCheck = realpath($this->container->get('kernel')->getRootDir() . '/../web/') . '/' . $path;

        // If the path does not exist, return the fallback image
        if (!file_exists($pathToCheck))
        {
            return $this->container->get('templating.helper.assets')->getUrl($fallbackPath);
        }

        // Return the real image
        return $this->container->get('templating.helper.assets')->getUrl($path);
    }

    /**
     * Returns the name of the extension.
     *
     * @return string The extension name
     */
    public function getName()
    {
        return 'asset_if';
    }
}