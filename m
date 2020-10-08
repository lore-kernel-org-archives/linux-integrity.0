Return-Path: <SRS0=oj+q=DP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5FBC43467
	for <linux-integrity@archiver.kernel.org>; Thu,  8 Oct 2020 11:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2321C217BA
	for <linux-integrity@archiver.kernel.org>; Thu,  8 Oct 2020 11:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJHLpV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 8 Oct 2020 07:45:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHLpV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Oct 2020 07:45:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65445AB8F;
        Thu,  8 Oct 2020 11:45:20 +0000 (UTC)
Date:   Thu, 8 Oct 2020 13:45:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20201008114518.GB27671@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.

> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
On both TPM 1.2 and TPM 2.0.
/sys/class/tpm/tpm0/pcr-sha*/* is exporting well on both.
James, thanks for implementing nice API!

BTW are all of these just TPM 1.2 specific?
/sys/class/tpm/tpm0/device/enabled
/sys/class/tpm/tpm0/device/pcrs
/sys/kernel/security/tpm0/binary_bios_measurements

Kind regards,
Petr
