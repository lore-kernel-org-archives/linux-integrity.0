Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD1C433F5
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Mar 2022 21:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiCTVXZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTVXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:23:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058F18A3E9;
        Sun, 20 Mar 2022 14:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA5DB80EFA;
        Sun, 20 Mar 2022 21:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9552CC340E9;
        Sun, 20 Mar 2022 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647811319;
        bh=VCO2HOCuTBN+Xv7u6MBQ5uA0+TGwA+QA643VoWQB4s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RH/gyeIDR4Y6vBxwoPf+bvJnNWspNNBT6gVUuJ9ByOxDzlcnQ1M4u09mnX13tV9c6
         q2FQMNR7zBKXmEBj4OcDYHkQD9+QXNGC4phBUINAh4Kq2rtvmRzsDQcAehbLm2zTFZ
         S66yZl1SlynQdT7eBHOzO79uVIDut3UFF8vGeXrmAKHLyMZIhWNHKAnCNTR/e7eFeV
         +FuwOc7ufk2jvR348NiSyo2dQrWbV3wGyizX1vilR/Hd6b8ie8XpkyYI/G23x9B6r6
         CcKnrUa1WLRAkGNRJ7MWVgFuTQxUwA6HrZYXC3XPfGlN8aWOtjje1HxTnhfYttgLgR
         IGANPRJRxzQow==
Date:   Sun, 20 Mar 2022 23:23:00 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, nayna@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tpm: ibmvtpm: Correct the return value in
 tpm_ibmvtpm_probe()
Message-ID: <YjebNG+q9kuh56iv@kernel.org>
References: <20220318060201.50488-1-xiujianfeng@huawei.com>
 <977ccc4b-3b30-f301-aa1c-ef2aaa32cacd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977ccc4b-3b30-f301-aa1c-ef2aaa32cacd@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 18, 2022 at 09:54:46AM -0400, Stefan Berger wrote:
> 
> 
> On 3/18/22 02:02, Xiu Jianfeng wrote:
> > Currently it returns zero when CRQ response timed out, it should return
> > an error code instead.
> > 
> > Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thank you, I applied this.

BR, Jarkko
