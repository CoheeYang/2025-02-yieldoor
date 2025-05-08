
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Integrator} from "./Actions/Integrator.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";

//  echidna test/AuditTest/CryticTester.sol --contract CryticTester --config echidna.yaml
// medusa fuzz
contract CryticTester is Integrator, CryticAsserts {
    constructor() payable {
        setup();
    }



}
