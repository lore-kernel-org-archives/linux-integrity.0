Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:52084 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbeCOQY3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 12:24:29 -0400
Message-ID: <d7d5a45fd2479eaf4495adde53391d53ee6d1ca6.camel@linux.intel.com>
Subject: Re: [tpmdd-devel] tpm device not showing up in /dev anymore
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Laurent Bigonville <bigon@debian.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Alexander.Steffen@infineon.com,
        linux-integrity@vger.kernel.org
Date: Thu, 15 Mar 2018 18:24:23 +0200
In-Reply-To: <58cd2dfe-24e7-e320-c7ef-153ba5855835@debian.org>
References: <20171111154516.GI17451@ziepe.ca>
         <20171111191257.owuqtgzie3ostsab@cantor> <20171111194647.GA6918@ziepe.ca>
         <20171111203132.hkejjs6cdrrzq3y3@cantor>
         <20171114145953.m3a343qvgln2z4er@linux.intel.com>
         <1510672631.4078.7.camel@HansenPartnership.com>
         <20171117131620.het4yxavz6lco6ow@linux.intel.com>
         <67ca8d8f-bd2c-a1ad-72d1-7f4b8df0a847@debian.org>
         <20180103003355.oaie7tych5lmtxiq@cantor>
         <bea3c5c2-4abe-27bc-3fe0-761457cca897@debian.org>
         <20180214114353.tw72tztmth2agpqu@linux.intel.com>
         <58cd2dfe-24e7-e320-c7ef-153ba5855835@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-09 at 18:24 +0100, Laurent Bigonville wrote:
> The duration that that was in your patch seems to work, cannot this be
> implemented?
>
> I'm quite surprised I'm the only one impacted by this...

Sorry it took so long time response but I had forgotten so too many
details.

After re-reading (PHEW!) the whole thread I'm thinking if we could
use section 5.5.2.4 as a reference to select a timeout of TIMEOUT_A
(albeit it is for request locality) and use Jerry's suggestion to
put wait_for_tpm_stat() there? Opinions?

/Jarkko
