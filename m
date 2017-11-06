Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:46878 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdKFTW5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2017 14:22:57 -0500
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 17A34603
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2017 19:22:57 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 70ADA69
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2017 19:22:56 +0000 (UTC)
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: IMA skips some file measurements
Date: Mon, 6 Nov 2017 19:22:55 +0000
Message-ID: <TU4PR84MB03023D92432F2AA6E9348873FF500@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

We are trying to understand why some file measurements are skipped
by IMA. In some circumstances, it seems that this could lead to an
incorrect assessment of the integrity of the host. Consider the
following, example in which we begin with a vulnerable bash binary
(e.g. Shellshock) and patch it.

1. Load vulnerable bash (measured by IMA)
2. Patch the bash file
3. Load good bash (measured by IMA)
4. Change back to vulnerable bash
5. Load vulnerable bash (not measured by IMA)

After step 5, the IMA logs appear to tell you that the system is using a
good binary, but a vulnerable binary is installed and being used.

We identified that 'ima_htable.queue' prevented the measurement at
step 5 since the same vulnerable bash was loaded on step 1 and 5 and
then its respective hash was already present in 'ima_htable.queue'.

So in this scenario the last/current file state is not identified using the 
IMA log. Is it not important to identify through the IMA log whether or 
not the last known file state is good?

Does anybody know why 'ima_htable.queue' is preventing already 
logged file hashes from being re-measured?

--
Guilherme
