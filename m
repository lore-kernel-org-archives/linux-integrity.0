Return-Path: <SRS0=E1tO=36=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049FBC2BA83
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 02:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0A2086A
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Feb 2020 02:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBJCxQ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:53:16 -0500
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:49188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbgBJCxO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Feb 2020 21:53:14 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Feb 2020 21:53:14 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 3E984181C9642
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 02:47:31 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DE317182CED34;
        Mon, 10 Feb 2020 02:47:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kite03_7b80b4af9b301
X-Filterd-Recvd-Size: 3446
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 02:47:28 +0000 (UTC)
Message-ID: <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
From:   Joe Perches <joe@perches.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 09 Feb 2020 18:46:13 -0800
In-Reply-To: <1581253027.5585.671.camel@linux.ibm.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
         <20200207195346.4017-2-tusharsu@linux.microsoft.com>
         <1581253027.5585.671.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-02-09 at 07:57 -0500, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Fri, 2020-02-07 at 11:53 -0800, Tushar Sugandhi wrote:
> > process_buffer_measurement() and ima_alloc_key_entry()
> > functions do not have log messages for failure conditions.
> > 
> > This change adds log statements in the above functions. 
> > 
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> The two patches you posted are related.  Please group them as a patch
> set, making this patch 2/2.
> 
> In addition, as Shuah Khan suggested for the security/integrity/
> directory, "there is an opportunity here to add #define pr_fmt(fmt)
> KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
> defines."  With Joe Perches patch (waiting for it to be re-posted),
> are all the pr_fmt definitions needed in each file in the
> integrity/ima directory?

btw Tushar and Lakshmi:

I am not formally submitting a patch here.

I was just making suggestions and please do
with it as you think appropriate.

and welcome, cheers, Joe

> > ---
> >  security/integrity/ima/ima_main.c       | 4 ++++
> >  security/integrity/ima/ima_queue_keys.c | 2 ++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 9fe949c6a530..afab796fb765 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -757,6 +757,10 @@ void process_buffer_measurement(const void *buf, int size,
> >  		ima_free_template_entry(entry);
> >  
> >  out:
> > +	if (ret < 0)
> > +		pr_err("Process buffer measurement failed, result: %d\n",
> > +			ret);
> 
> There's no reason to split the statement like this.  The joined line
> is less than 80 characters.
> 
> > +
> >  	return;
> >  }
> >  
> > diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> > index c87c72299191..2cc52f17ea81 100644
> > --- a/security/integrity/ima/ima_queue_keys.c
> > +++ b/security/integrity/ima/ima_queue_keys.c
> > @@ -90,6 +90,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> >  
> >  out:
> >  	if (rc) {
> > +		pr_err("Key entry allocation failed, result: %d\n",
> > +			rc);
> 
> ditto
> 
> >  		ima_free_key_entry(entry);
> >  		entry = NULL;
> >  	}
> 
> thanks,
> 
> Mimi
> 

