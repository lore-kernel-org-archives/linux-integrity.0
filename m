Return-Path: <SRS0=IrrW=RQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0821CC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 14:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99BE2171F
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCMOAZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:00:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:39034 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfCMOAZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Mar 2019 10:00:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 07:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="326937269"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.103])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2019 07:00:23 -0700
Date:   Wed, 13 Mar 2019 16:00:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
Message-ID: <20190313140022.GB6862@linux.intel.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
 <1552168908.3442.5.camel@HansenPartnership.com>
 <1552171467.3442.13.camel@HansenPartnership.com>
 <20190311130908.GA7264@linux.intel.com>
 <14297706-74ef-f178-3b65-e63289919117@intel.com>
 <1552431049.14432.42.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552431049.14432.42.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 12, 2019 at 03:50:49PM -0700, James Bottomley wrote:
> On Tue, 2019-03-12 at 15:42 -0700, Tadeusz Struk wrote:
> > @@ -202,13 +196,15 @@ __poll_t tpm_common_poll(struct file *file,
> > poll_table *wait)
> >  	struct file_priv *priv = file->private_data;
> >  	__poll_t mask = 0;
> >  
> > +	mutex_lock(&priv->buffer_mutex);
> >  	poll_wait(file, &priv->async_wait, wait);
> >  
> > -	if (!priv->response_read || priv->response_length)
> > +	if (priv->response_length)
> >  		mask = EPOLLIN | EPOLLRDNORM;
> >  	else
> >  		mask = EPOLLOUT | EPOLLWRNORM;
> >  
> > +	mutex_unlock(&priv->buffer_mutex);
> 
> Isn't this setting us up for a deadlock?  If the work queued by write
> hasn't run by the time you call poll, you take the buffer mutex and
> sleep.  Now if the work runs, it blocks acquiring the mutex in
> tpm_async_work and never calls wakeup on async_wait.

Yes, the lock should be taken after poll_wait().

/Jarkko
