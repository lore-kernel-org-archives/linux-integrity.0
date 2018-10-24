Return-Path: <SRS0=CR94=NE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295CECDE44
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113362075D
	for <linux-integrity@archiver.kernel.org>; Wed, 24 Oct 2018 16:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ejGccIjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113362075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJYA5R (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:57:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50114 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbeJYA5R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Oct 2018 20:57:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 959728EE27E;
        Wed, 24 Oct 2018 09:28:32 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c4rlw2NF_Qp9; Wed, 24 Oct 2018 09:28:32 -0700 (PDT)
Received: from [10.101.217.208] (unknown [185.7.230.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5D2E28EE055;
        Wed, 24 Oct 2018 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540398512;
        bh=qjsNOkDgcKIGU+uNIZG3OQVMVXM2/MXcOFjM9w2/s9E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ejGccIjGq8tbw1DMkxRcjWAYaJvjsGn0JM03V+bWYMdxzoo4DkITDsxyE12GfVXWV
         WPI3hnQrvXePeTFFYmpQ+kMUdaPhS0ezLRakkKblYBgzlIDI6IdfWeTnR+51AEipKU
         6fTLXNyPv7EZOai9B3/WCrEruzkvXI+NWa0dTvZ4=
Message-ID: <1540398506.3142.0.camel@HansenPartnership.com>
Subject: Re: Aw: Re: LSS-EU BoF(s) (renamed from LPC 2018)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Peter Huewe <PeterHuewe@gmx.de>,
        Monty Wiseman <montywiseman32@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>, serge@hallyn.com,
        chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        dpsmith@apertussolutions.com
Date:   Wed, 24 Oct 2018 17:28:26 +0100
In-Reply-To: <trinity-2564d361-b0c0-44bc-a099-c845e46061a7-1540396532523@3c-app-gmx-bs24>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <1539642523.2867.44.camel@HansenPartnership.com>
         <alpine.LRH.2.21.1810160946210.2779@namei.org>
         <1539691005.11939.258.camel@linux.ibm.com>
         <alpine.DEB.2.21.1810180301090.5022@jsakkine-mobl1>
         <7831fac7-40ba-a3e8-61c8-166a54cfe515@linux.ibm.com>
         <alpine.DEB.2.21.1810231616200.19836@jsakkine-mobl1>
         <1540301465.2787.4.camel@HansenPartnership.com>
         <1540301816.5583.187.camel@linux.ibm.com>
         <305bc8a7-876f-f1d3-9076-1a5b9c3daca3@gmail.com>
         <trinity-2564d361-b0c0-44bc-a099-c845e46061a7-1540396532523@3c-app-gmx-bs24>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-10-24 at 17:55 +0200, Peter Huewe wrote:
> Hi,
> what is now the concensus on the BOF(s) time and location

Moffat room, Level -2 in the Convention Centre at 18:00 today
(Wednesday).

James

