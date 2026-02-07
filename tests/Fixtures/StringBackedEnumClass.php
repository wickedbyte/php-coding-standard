<?php

declare(strict_types=1);

namespace WickedByte\CodingStandard\Tests\Fixtures;

enum StringBackedEnumClass: string
{
    case FOO = SimpleClass::FOO;
    case BAR = 'bar';
}
