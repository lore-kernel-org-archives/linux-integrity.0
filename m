Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:10440 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeFEVWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jun 2018 17:22:12 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 3B1C5DD4
        for <linux-integrity@vger.kernel.org>; Tue,  5 Jun 2018 21:22:12 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 9C24482
        for <linux-integrity@vger.kernel.org>; Tue,  5 Jun 2018 21:22:11 +0000 (UTC)
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: violations and invalidated PCR value
Date: Tue, 5 Jun 2018 21:22:10 +0000
Message-ID: <AT5PR8401MB113985C429E1F854FE9B62D3FF660@AT5PR8401MB1139.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi,
I am trying to understand why violations (tomtou, open writers) cause 
the aggregated PCR value to be invalidated. 

Invalidating the PCR makes clear the file measurement errors, but once 
violations are common (when using the (TCB) default policy) it seems 
difficult to perform a full attestation process if violations are not 
handled.

Is it safe to just report the violations and still perform a full attestation 
of the log by replacing zeroed digest with ff..ff? I believe we can safely 
detect a violation entry in the log by checking the hash values are zeroes. 
Please confirm.

Thank you.
--
Guilherme
