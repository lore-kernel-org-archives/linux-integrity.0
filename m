Return-Path: <SRS0=T3zP=DU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70364C433E7
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Oct 2020 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD7251BE
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Oct 2020 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgJMPao (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:30:44 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:54280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726749AbgJMPao (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 11:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 75E3B837F24D;
        Tue, 13 Oct 2020 15:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kiss33_4a0b51627204
X-Filterd-Recvd-Size: 1377
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 15:30:41 +0000 (UTC)
Message-ID: <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com ->
 jarkko@kernel.org
From:   Joe Perches <joe@perches.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-sgx@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 13 Oct 2020 08:30:38 -0700
In-Reply-To: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
References: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-13 at 13:46 +0300, Jarkko Sakkinen wrote:
> Use korg address as the main communications end point. Update the
> corresponding M-entries.

Maybe add an equivalent entry to .mailmap?

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> -M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +M:	Jarkko Sakkinen <jarkko@kernel.org>


