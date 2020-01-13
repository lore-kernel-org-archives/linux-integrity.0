Return-Path: <SRS0=qoUO=3C=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD3C33CA9
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Jan 2020 00:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB48C222D9
	for <linux-integrity@archiver.kernel.org>; Mon, 13 Jan 2020 00:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgAMAHO (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:07:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:27165 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387503AbgAMAHO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jan 2020 19:07:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 16:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,426,1571727600"; 
   d="scan'208";a="247554391"
Received: from akurtz1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.10.99])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2020 16:07:10 -0800
Date:   Mon, 13 Jan 2020 02:07:09 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        labbott@redhat.com
Subject: Re: [PATCH] tpm: handle negative priv->response_len in
 tpm_common_read
Message-ID: <20200113000709.GB16145@linux.intel.com>
References: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
 <157843468820.24718.10808226634364669421.stgit@tstruk-mobl1>
 <b469b7e8454a69402529cc8e25244860e136308e.camel@linux.intel.com>
 <80272f0259d967fe61dacd1036cbbd9f555b8402.camel@linux.intel.com>
 <d1ee03ce-c8bd-75ab-e348-8a05fb6be69d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ee03ce-c8bd-75ab-e348-8a05fb6be69d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 08, 2020 at 09:47:31AM -0800, Tadeusz Struk wrote:
> On 1/8/20 8:04 AM, Jarkko Sakkinen wrote:
> > Applied but had to fix bunch of typos, missing punctaction and
> > missing parentheses in the commit message. Even checkpatch.pl
> > was complaining :-/
> 
> Forgot about the checkpatch.pl thing. Sorry.

NP, just mentioning this for the future patches.

/Jarkko
