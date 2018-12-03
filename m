Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D7C04EB9
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B90B20848
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B90B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLCSAq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:00:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:59471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeLCSAq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 13:00:46 -0500
Received: from Peter-MotoG5.fritz.box ([93.235.184.20]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lb4vZ-1hDtVG1cXR-00kdpc; Mon, 03 Dec 2018 19:00:31 +0100
Date:   Mon, 03 Dec 2018 19:00:26 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181203175546.GB10562@linux.intel.com>
References: <20181130233501.GA32256@linux.intel.com> <1543764226.4216.205.camel@linux.ibm.com> <1543775366.2732.24.camel@HansenPartnership.com> <20181202231327.GC6718@linux.intel.com> <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70> <20181203172922.GA12237@ziepe.ca> <20181203175509.GA10562@linux.intel.com> <20181203175546.GB10562@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Re: TPM legacy
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
From:   Peter Huewe <peterhuewe@gmx.de>
Message-ID: <4BE33FDA-128C-438E-8882-548B9E2848E9@gmx.de>
X-Provags-ID: V03:K1:yOxAFEAhTVpFVHDzwBKFYq6LhDvMVDfBWnIihdzB3JpIOkRmnyx
 QBQF4Vin0cz55M7aP87UV/Zqa/SGyzq/91w0g5dj9dQUbWogG3q42mosWQ6wbfwDIw799RA
 zBww/pQSuhHx3N9mRUV2hnkl8p+H04WVI84yHMY/X08goG6O1Qe0rKcCsCGMpfhDkFblT9c
 lPh3uJTrW8KoyNgV2LNfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Wmp0nvUCl0=:oqR5TDtCULzCCNijt2sSwi
 ry/OzWplhiuXEEpiv8/RuN5dq9z3wr18Wq8ad070VqweXp/14iaB+Woy68iGComKJgu2NN9xx
 zEvcjCkYKmAVVAXZeLahQVqxUhvxG48K7AVQ5s7upS9SP+EYDUedXHiLUV4iMTDmk0aMbkCB0
 OdpX0/U3kSqa4ZZGmov+tzb/SHo5O3BMmMMrgsfM7+5uPca9nTOF6rIyVC9hVc1Ny9fFwjbxV
 HCjYVMaUPKDl7Vj8FiNGnpfAUPk+prRQ+3a9nPdW60W1nES41pRz3cE9XLk82Jr3CgjWKCvw+
 Al4JJ6w9t8jvPPFHtUU+vtK+1e4SFsxPHEFSatKDIHMsUWPWH+XI8N408HD+h9iglK1fsFxAX
 ceAkw2oHEytq6hrsHiZg8h0UNgOaCoxm3Z2IN5uqLfslHBEAf+kI1J+xpC8g+X3q6Jl4Sl2/r
 E9A335xpfs0GKdXWiTUAajxUCXNltk6QMR6kMQ+mRFf99LfdN4RnhI/MkITrUk+HSQJX5Th2N
 LgTSmsl1MP6jBOucdbcoh6vsnYZQyVR3/CfOrfc1nrLUvy3KTxlqXBws0zsKgLhaGxhq28ked
 93EGBNL6Teb22aIYsF4LcTuL+DH7ABXv/4Ave+T1yR2jTgzR6s2BC6Ev2mwED1RU1GF2xJyEC
 1Gf9c6XmmexuSwz1gdFdlmOz4oFTbS8Txj2+2C6tY2l5d73CgyygkWFs3/ausmRREMUUzOneE
 2/2uPOaCVTiToeqzJjn0RXAtQbcrHhI0qxO3yZixe9fA8HpDuI+fhAi4nnSO1CUFJd692Y4KJ
 Y7yfrSIFwRpbhxj1+OeACilonEvKNFFyPHHMVdJ4tBMm5yrfiML0M7kdg+857ZVGsFSOstMD0
 9xxByeJjJhugYQFCCZnsOWkJbcb/ifmJ9zzQwG7fpGqybNawOHr2lCFZJ9DM4x
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Am 3. Dezember 2018 18:55:46 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>On Mon, Dec 03, 2018 at 09:55:09AM -0800, Jarkko Sakkinen wrote:
>> On Mon, Dec 03, 2018 at 10:29:22AM -0700, Jason Gunthorpe wrote:
>> > On Mon, Dec 03, 2018 at 04:01:38PM +0100, Peter Huewe wrote:
>> > 
>> > > The only thing I would want to get rid of are the *1.1b based*
>> > > drivers - they are probably end of life since quite some time. 
>The
>> > > TIS driver&specification has been around since 2005 if not
>longer...
>> > 
>> > I also wanted to do this, I feel like these drivers probably don't
>> > work any more after all the churn in the past few years..
>> 
>> I'm with you on this but yeah, better to do it now so that it gets
>> maximum exposure in linux-next (i.e. would land to 4.22).
>
>And superimportat to CC this commit also to LSM.
>
>/Jarkko
Correct would be to move them to stagimg first.
See my thread on ksummit-discuss for details.
Peter

-- 
Sent from my mobile
