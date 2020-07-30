Return-Path: <SRS0=cYPt=BJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48232C433E0
	for <linux-integrity@archiver.kernel.org>; Thu, 30 Jul 2020 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACA92074B
	for <linux-integrity@archiver.kernel.org>; Thu, 30 Jul 2020 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596139135;
	bh=x5Z5Lcy+lf5VlE+mnhIdU70vykDcR9T41o85m5TGRC4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=wboB4xbpNxDmzx9c19rPz903KqzamGmNPFke4WWc734rvTzEcp1+/IokjH+HPRA+Y
	 RQfK4Zk9OiwAXvVXmpw+QiZPXHJoXUHUu+TN70R0KEirdWvrLJ0/iRHypge8gMKODC
	 F6SHIRSmmtNE4LUxGNhPOJncQuJE3Mz+tCjY6vLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgG3T6y (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbgG3T6x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 15:58:53 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B6C20656;
        Thu, 30 Jul 2020 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596139133;
        bh=x5Z5Lcy+lf5VlE+mnhIdU70vykDcR9T41o85m5TGRC4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d5K8FZnF+X3fFCVHtPjw/TcDLxsBZkNTAvWve/b1YLOaZrm/SKsWT3wYbzTuJT/91
         a9V+SS+PhWAoqFWD0OW9AJ82V+nZFUGksmmtGAezpAQoRLQvuM8czrXGeo7UM8TXZd
         BILb2kAJd5dwdCvsLiIpDCoZuDTrwQFnFhQugC7E=
Message-ID: <1596139131.25003.14.camel@kernel.org>
Subject: Re: [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:58:51 -0400
In-Reply-To: <20200728001301.31121-1-pvorel@suse.cz>
References: <20200728001301.31121-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-28 at 02:13 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> [ pvorel: improved setup, various LTP API cleanup ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, really nice.

Missing is a short comment explaining the reason for the multiple
tests.

> +test()
> +{
> +	case $1 in
> +	1) kexec_test '--reuse-cmdline';;
> +	2) kexec_test '--append' 'foo';;
> +	3) kexec_test '--command-line' 'bar';;
> +	esac
> +}
> +
> +tst_run

