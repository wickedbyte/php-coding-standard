<?php

declare(strict_types=1);

namespace WickedByte\CodingStandard\Tests\Fixtures;

class SimpleClass
{
    public const string FOO = 'foo';

    public function __construct(public string $foo)
    {
        if ($foo === self::FOO) {
            throw new \RuntimeException('foo cannot be ' . self::FOO);
        }
    }
}
