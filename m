Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26941 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeBPTPW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 14:15:22 -0500
From: "Sun, Ning" <ning.sun@intel.com>
To: "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "tpm2@lists.01.org" <tpm2@lists.01.org>
CC: "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [tpm2] ESYS API pull request review to start 2018-02-05
Date: Fri, 16 Feb 2018 19:15:20 +0000
Message-ID: <83BE7A8C0111FD48951B68B36BEFDFD40D16C457@ORSMSX107.amr.corp.intel.com>
References: <a525b28f-aaf3-58c1-7b13-1c4d8d52d22e@twobit.us>
 <DB638850A6A2434A93ECADDA0BC838905F124692@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <DB638850A6A2434A93ECADDA0BC838905F124692@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Are there going to be another version of tpm2 tools based on ESAPI?

Thanks,
-Ning 

-----Original Message-----
From: tpm2 [mailto:tpm2-bounces@lists.01.org] On Behalf Of Tricca, Philip B
Sent: Friday, February 16, 2018 10:41 AM
To: tpm2@lists.01.org
Cc: Peter.Huewe@infineon.com; linux-integrity@vger.kernel.org
Subject: Re: [tpm2] ESYS API pull request review to start 2018-02-05

We got started a bit late, and the review ran a bit late, but the PR adding the Enhanced System API (Esys, aka ESAPI) has now been merged into our TSS2 library repo: https://github.com/tpm2-software/tpm2-tss/commit/ff821bd3ed112c3ddfb27aadd6898789a2545d2d. Our PR queue is now unblocked and I'll be spending some time today doing the usual maintenance that's built up. Thanks to everyone who put some of their time into the review. 

Special thanks to SIT for all of their hard work writing the code and working with us through the review, and to Infineon for sponsoring the work and enabling its release as OSS.

For those looking to work with the ESAPI library now that it's been merged, the TCG has reshuffled their website (... again) and the spec is now here: https://trustedcomputinggroup.org/tcg-tss-2-0-enhanced-system-api-esapi-specification/

Regards,
Philip

-----Original Message-----
From: tpm2 [mailto:tpm2-bounces@lists.01.org] On Behalf Of philip.b.tricca@intel.com
Sent: 1 February, 2018 23:39
To: tpm2@lists.01.org
Cc: linux-integrity@vger.kernel.org
Subject: [tpm2] ESYS API pull request review to start 2018-02-05

Sorry for the spam but this topic has been discussed at the plumbers TPM microconf and so I thought the wider audience might find this interesting / relevant:

The OSS implementation of of the TCG TSS2 core libraries / APIs is working its way toward a version 2.0 release and we're a few days away from starting a pull request & review that will add the "Enhanced System API". This new API adds additional features like automating the application side of the hash and encryption operations for HMAC and encrypted sessions.

If you're interested the spec is available here:
https://trustedcomputinggroup.org/wp-content/uploads/TSS_ESAPI_Version-0.9_Revision-04_reviewEND030918.pdf

Given the size of this generous code contribution (our thanks to Fraunhofer SIT and Infineon), this PR will be under review for several days. During this time lower priority PRs will be delayed and we may build up a bit of a queue.
_______________________________________________
tpm2 mailing list
tpm2@lists.01.org
https://lists.01.org/mailman/listinfo/tpm2
