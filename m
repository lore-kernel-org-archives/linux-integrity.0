Return-Path: <SRS0=HrVK=65=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCDC433E0
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A9A20728
	for <linux-integrity@archiver.kernel.org>; Fri, 15 May 2020 19:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t0g067pI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t0g067pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOTel (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 15 May 2020 15:34:41 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53698 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgEOTel (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 15:34:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A9CD48EE2CA;
        Fri, 15 May 2020 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589571280;
        bh=+CadYKAxrvUHmhM9lJ9FfAZvxQnrlNAj/52iL48Wuws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t0g067pI2e4W3FS4SinFpKgds/X/r7pmOkm7lerTR2OPuHHGAbJvATsfFptB+RL3O
         MR+4SYjHAbUMIclvkF25rapnO7Xq61cLKThMXJHenf+lq/zs4BYGdByJoLun0Wp9W+
         q/d+sr3qZHda+ZIO7o+RncaeSJcqJpY1xQmL6r9k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qi6cQuMByczq; Fri, 15 May 2020 12:34:40 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 146738EE25D;
        Fri, 15 May 2020 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589571280;
        bh=+CadYKAxrvUHmhM9lJ9FfAZvxQnrlNAj/52iL48Wuws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t0g067pI2e4W3FS4SinFpKgds/X/r7pmOkm7lerTR2OPuHHGAbJvATsfFptB+RL3O
         MR+4SYjHAbUMIclvkF25rapnO7Xq61cLKThMXJHenf+lq/zs4BYGdByJoLun0Wp9W+
         q/d+sr3qZHda+ZIO7o+RncaeSJcqJpY1xQmL6r9k=
Message-ID: <1589571278.3653.22.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 12:34:38 -0700
In-Reply-To: <20200515191758.ieojyk5xhsx2hzzd@cantor>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 12:17 -0700, Jerry Snitselaar wrote:
> On Fri May 15 20, Jarkko Sakkinen wrote:
> > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> > > On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
[...]
> > > > sudo ./keyctl-smoke.sh
> > > > 566201053 (0x80000000)
> > > > keyctl_read_alloc: Permission denied
> 
> I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play with
> keyctl print.
> If I 'sudo su -' and then try it works as expected. Also works for
> normal user.

OK, I confirm on debian as well.  If I create a key as real root and
then try to sudo su keyctl pipe it as an ordinary user, I get EPERM.

It smells like a cockup in real vs effective permissions somewhere in
the keyctl handler.

James

