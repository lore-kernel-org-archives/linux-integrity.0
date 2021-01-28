Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37355C433E9
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Jan 2021 04:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E443564DE0
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Jan 2021 04:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhA1E6D (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:58:03 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:50834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229545AbhA1E6D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 23:58:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 54824181D341E;
        Thu, 28 Jan 2021 04:57:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fan51_55072612759c
X-Filterd-Recvd-Size: 2289
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 04:57:17 +0000 (UTC)
Message-ID: <d6ddcab2f9db25f49e89f37e1cb4f59ad42651e6.camel@perches.com>
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
From:   Joe Perches <joe@perches.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 27 Jan 2021 20:57:16 -0800
In-Reply-To: <871re5soof.fsf@manicouagan.localdomain>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
         <20210115173017.30617-10-nramas@linux.microsoft.com>
         <20210127165208.GA358@willie-the-truck>
         <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
         <20210127184319.GA676@willie-the-truck>
         <871re5soof.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-28 at 00:52 -0300, Thiago Jung Bauermann wrote:
> The problem is that this patch implements only part of the suggestion,
> which isn't useful in itself. So the patch series should either drop
> this patch or consolidate the FDT allocation between the arches.
> 
> I just tested on powernv and pseries platforms and powerpc can use
> vmalloc for the FDT buffer.

Perhaps more sensible to use kvmalloc/kvfree.



