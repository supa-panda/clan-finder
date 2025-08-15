<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ClanController extends AbstractController
{
    #[Route('/clan', name: 'clan_index')]
    public function index(): Response
    {
        $clans = [
            ['name' => 'Clan A', 'members' => 10],
            ['name' => 'Clan B', 'members' => 20],
            ['name' => 'Clan C', 'members' => 15],
        ];

        return $this->json(['clans' => $clans]);
    }
}
