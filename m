Return-Path: <SRS0=OCRO=YS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99568CA9EBD
	for <linux-integrity@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5C920650
	for <linux-integrity@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437851AbfJYI5S (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:57:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438169AbfJYI5S (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 04:57:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68A73B3A4;
        Fri, 25 Oct 2019 08:57:16 +0000 (UTC)
Date:   Fri, 25 Oct 2019 10:56:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?iso-8859-2?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191025085617.GA13329@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025021159.dt7ifgnebnke6ca7@cantor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it elsewhere on other distros?)

> versus

> /sys/class/tpm/tpmX/major_version

Is it more HW related (/sys/class/tpm/tpmX) or LSM related
(/sys/kernel/security/tpmX)?
I guess /sys/kernel/security/tpmX might be better.

Thanks for implementing this, I'll try to test it soon.

Kind regards,
Petr
