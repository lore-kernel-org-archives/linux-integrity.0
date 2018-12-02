Return-Path: <SRS0=SF38=OL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF1C04EB8
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9C820834
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 23:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9C820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLBXIu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:08:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:34625 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeLBXIu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 18:08:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2018 15:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,308,1539673200"; 
   d="scan'208";a="104104912"
Received: from trhammer-mobl.amr.corp.intel.com (HELO localhost) ([10.254.49.188])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2018 15:08:48 -0800
Date:   Sun, 2 Dec 2018 15:08:47 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: TPM legacy
Message-ID: <20181202230847.GB6718@linux.intel.com>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543764226.4216.205.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 02, 2018 at 10:23:46AM -0500, Mimi Zohar wrote:
> On Fri, 2018-11-30 at 15:35 -0800, Jarkko Sakkinen wrote:
> > Hi
> > 
> > Some things that came up at LSS.
> > 
> > First, would it be time to drop 1.1b bits? What advantages this would
> > bring? AFAIK Peter is a strong supporter of this.
> > 
> > In the hall way discussions, I talked with Tomas Winkler that it would
> > make sense to add CONFIG_TCG_TPM1 flag to completely leave out all TPM
> > 1.x bits from the kernel.
> > 
> > TPM 1.x stuff is not exactly legacy but especially on IoT does not make
> > sense to carry that code with.
> 
> New systems might be shipping with only TPM 2.0, but it still needs to
> be supported for existing systems, probably for quite a while.  Having
> the option to build the kernel with TPM 1.2, TPM 2.0 or both, is
> acceptable.

I guess it would be sufficient to just have an option to compile TPM 1.x
out for starters as the real use case is devices with fTPM. Hard to see
much benefit on supporting compiling TPM 2.0 support out. Obviously,
TCG_TPM1 would be by default off.

/Jarkko
