<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
// Use auto router 
use Symfony\Component\Routing\Annotation\Route;
// Use render function
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class homePage extends AbstractController
{
    
    /**
     * @Route("/home")
     */
    public function getHomePage()
    {
        

        return $this->render('home/home.html.twig');

    }
}