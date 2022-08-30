Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF23ECAAD4
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Aug 2022 13:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH3NGH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH3NGG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 09:06:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE2A1D4B
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 06:06:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5681721C8C;
        Tue, 30 Aug 2022 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661864762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZ+4loWIzVLeFLHkOX7cUmbsLPkqxgj+AW8UOSRZoBw=;
        b=O95vMrZYH3+82XJT3Ka2enHOWGoGFWFG2g2B3XMPAIKB0ucIxLYJh6aAyGzL3OLYzqnbcl
        EqvhCTC7+mVXwmGWSWs2nW5TsQtGg8wVbG/LXzpo5q7/JauwDbukIItk4OHrLWY4CKVsDy
        YGGcvZCChRWvMVATUKRMql+X3buuFTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661864762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZ+4loWIzVLeFLHkOX7cUmbsLPkqxgj+AW8UOSRZoBw=;
        b=XtaZLgRpCWIW+RvZC7sQvgOxpcQfbRjaDbB5U4aGUmunoobbYLBgyMdrWRX9JC9a+LYXF0
        0FWVXjpbsf1sJnDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E0CF13B0C;
        Tue, 30 Aug 2022 13:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 48fHAToLDmNSdwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 13:06:02 +0000
Date:   Tue, 30 Aug 2022 15:06:00 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 11/11] Missing template data size lower
 bounds checking
Message-ID: <Yw4LOJO1/WUB5C2g@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-12-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-12-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Each record in the IMA measurement list must contain some template data.
> Ensure the template data is not zero length.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
