<?php

namespace Hero\Spec;

use \Hero\Superman;


describe('Superman', function () {

    it('definitely should fly', function () {
        expect((new Superman())->canFly())->toBe(true);
    });

});
