Return-Path: <SRS0=E1tO=36=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380AC352A3
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EC920661
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJQv7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:51:59 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:57461 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgBJQv7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 11:51:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DFEA2182CED34;
        Mon, 10 Feb 2020 16:51:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birds64_4b141cff4044f
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 16:51:55 +0000 (UTC)
Message-ID: <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
From:   Joe Perches <joe@perches.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 08:50:40 -0800
In-Reply-To: <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
         <20200207195346.4017-2-tusharsu@linux.microsoft.com>
         <1581253027.5585.671.camel@linux.ibm.com>
         <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
         <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 08:40 -0800, Lakshmi Ramasubramanian wrote:
> On 2/9/20 6:46 PM, Joe Perches wrote:
> 
> > > In addition, as Shuah Khan suggested for the security/integrity/
> > > directory, "there is an opportunity here to add #define pr_fmt(fmt)
> > > KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
> > > defines."  
> 
> Good point - we'll make that change.
> 
> With Joe Perches patch (waiting for it to be re-posted),
> > > are all the pr_fmt definitions needed in each file in the
> > > integrity/ima directory?
> > 
> > btw Tushar and Lakshmi:
> > 
> > I am not formally submitting a patch here.
> > 
> > I was just making suggestions and please do
> > with it as you think appropriate.
> 
> Joe - it's not clear to me what you are suggesting.
> We'll move the #define for pr_fmt to integrity.h.
> 
> What's other changes are you proposing?

https://lore.kernel.org/lkml/4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com/


