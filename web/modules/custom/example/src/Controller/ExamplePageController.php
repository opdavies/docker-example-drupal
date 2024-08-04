<?php

declare(strict_types=1);

namespace Drupal\example\Controller;

use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\Core\StringTranslation\StringTranslationTrait;

final class ExamplePageController {

  use StringTranslationTrait;

  public function __construct(
    private LoggerChannelFactoryInterface $logger,
  ) {}

  /**
   * @return array<string,mixed>
   */
  public function __invoke(): array {
    $this->logger->get('example')->info('Example page viewed.');

    return [
      '#markup' => $this->t(
        'This is an example page from the <a href="@url">Drupal Module Template</a>.',
        ['@url' => 'https://github.com/opdavies/drupal-module-template']
      ),
    ];
  }

}
