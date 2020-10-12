Return-Path: <SRS0=clxO=DT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35BBC433DF
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Oct 2020 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2A20878
	for <linux-integrity@archiver.kernel.org>; Mon, 12 Oct 2020 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgJLXzJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:55:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:20992 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgJLXzI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:55:08 -0400
IronPort-SDR: 3GFYgVk+GQCZSlXQDC9h9DdYFMG49IcrwGpnzYoKqTunWJdGqzWakGRFHJTytU2VMzLlwEC8XN
 bQzEeHYfuZhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="145139069"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="145139069"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 16:55:07 -0700
IronPort-SDR: SV0qYb63niNV9GMArm2g502LOO41WCibREwQLWEdJpDSZOVJp3Wfeu2Ylls0Vzbg/P9gkErI/D
 AupL5AM/4/Zw==
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="530165565"
Received: from lusin-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.81])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 16:55:04 -0700
Date:   Tue, 13 Oct 2020 02:55:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v1] dm verity: Add support for signature verification
 with 2nd keyring
Message-ID: <20201012235502.GA36149@linux.intel.com>
References: <20201002071802.535023-1-mic@digikod.net>
 <bda2ffd7-3b7c-33a4-667f-a3435e112fc1@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bda2ffd7-3b7c-33a4-667f-a3435e112fc1@digikod.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 09, 2020 at 11:50:03AM +0200, Mickaël Salaün wrote:
> Hi,
> 
> What do you think about this patch?
> 
> Regards,
>  Mickaël
> 
> On 02/10/2020 09:18, Mickaël Salaün wrote:
> > From: Mickaël Salaün <mic@linux.microsoft.com>
> > 
> > Add a new DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING configuration
> > to enable dm-verity signatures to be verified against the secondary
> > trusted keyring.  This allows certificate updates without kernel update
> > and reboot, aligning with module and kernel (kexec) signature
> > verifications.

I'd prefer a bit more verbose phrasing, not least because I have never
really even peeked at dm-verity, but it is also a good practice.

You have the middle part of the story missing - explaining the semantics
of how the feature leads to the aimed solution.

/Jarkko
