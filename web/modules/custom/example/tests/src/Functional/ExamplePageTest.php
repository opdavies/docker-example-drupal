<?php

namespace Drupal\Tests\example\Functional;

use Drupal\Tests\BrowserTestBase;
use Symfony\Component\HttpFoundation\Response;

final class ExamplePageTest extends BrowserTestBase {

  public $defaultTheme = 'stark';

  protected static $modules = [
    // Core.
    'node',

    // Custom.
    "example"
  ];

  /** @test */
  public function should_load_the_example_page_for_anonymous_users(): void {
    // Arrange.

    // Act.
    $this->drupalGet('/@opdavies/drupal-module-template');

    // Assert.
    $this->assertSession()->statusCodeEquals(Response::HTTP_OK);
  }

}
