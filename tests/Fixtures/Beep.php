<?php

declare(strict_types=1);

namespace WickedByte\CodingStandard\Tests\Fixtures;

enum Beep: int
{
    case Foo = 1;
    case Bar = 2;

    public function isOdd(): bool
    {
        return (bool)($this->value % 2);
    }
}
