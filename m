Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:6075 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdJCQJE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Oct 2017 12:09:04 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 6DA4B2709
        for <linux-integrity@vger.kernel.org>; Tue,  3 Oct 2017 16:09:04 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (g4w9121.houston.hp.com [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id D01BE63
        for <linux-integrity@vger.kernel.org>; Tue,  3 Oct 2017 16:09:03 +0000 (UTC)
From: "Magalhaes, Guilherme (Brazil R&D-CL)" <guilherme.magalhaes@hpe.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: IMA measurement performance degradation
Date: Tue, 3 Oct 2017 16:08:41 +0000
Message-ID: <TU4PR84MB03022FBD0B5B5EF9E7294B99FF720@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB0302696A2C214711B9C5DCC4FF7D0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR84MB0302C3D9C184EDB8B722EE68FF7D0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Mimi.

We are measuring IMA performance analyse vTPM performance/scalability, once 
vTPM is going to be used when IMA measurements and log are namespaced. With 
the analysis, we identified one possible improvement in IMA.

The problem is a performance degradation caused by the IMA measurement hash 
table (ima_htable). The analysis executes many file accesses (measurements) with 
different types of workloads and configurations. I will restrict the experiment 
configuration to the ones important to this problem. Scenario #1 is with files 
outside the IMA policy and scenario #2 is with files in the IMA policy. On the 
scenario #2, we disabled the TPM chip (enabling us to see other bottlenecks 
besides the TPM chip). 

See the chart at:
https://drive.google.com/file/d/0ByxwRmmxIzLYcEdEMV9xZFlUYlE/view?usp=sharing. 
The X axis is the number of process running the workload and the Y axis is the total 
number of file create/read (measurements) performed. The red line is scenario #1 
and the green line is scenario #2.

The green line makes clear there is a performance degradation in the IMA 
measurement path whereas file measurements are performed. We then spot in the 
source code that IMA manages along with the IMA log a hash table where entries 
are references to the IMA log entries structured in a linked list inside each bucket. 
We profiled this hash table and realized each bucket list increases in time to 
thousands of entries. On each new file measurement, before a new entry is 
added to the IMA log, the new entry is looked up in the hash table by traversing 
sequentially a certain bucket list. This linked list then considerably slows down the 
measurement process and also explain the performance degradation. We 
removed this hash table entirely to run the experiments and IMA measurement 
performed at the same pace when files are not in the policy. The TPM chip is still 
the biggest bottleneck, but this hash table bottleneck will impact performance 
when vTPMs are supported in IMA (more details to be provided).

What this hash table is needed for? I believe it is used just to avoid duplicated 
entries in the IMA log. On this case, the IMA_MEASURED flag should be sufficient. 
Is the hash table required as a safety net for the inode/iint cache evictions 
controlled automatically by the kernel, since that flag is part of the iint cache? 
If this hash table is really needed, could it be replaced with a red black tree?

--
Guilherme
