Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B9DC4332F
	for <linux-integrity@archiver.kernel.org>; Fri,  4 Nov 2022 21:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKDVfY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKDVfX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 17:35:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656CC45EC1
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 14:35:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26F1E21983;
        Fri,  4 Nov 2022 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667597721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=nGql36LBy0BYSNffbSCT+3SRwrJSLe2xzt8o5gSI5wf3JF8t+MSjhECtwuH7FxQQpyRjWi
        VgBfrnhV87cwGXn3SD8ln25SoiXrFU1VaoCDY4z27tcnaZErrQVXuzOWxVUGjKo+9MaOPV
        dvI1r++8nd2APb9RgMukKrsNxkPgr3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667597721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=PXjugNr1ODhk9EA0bAeqJh5u6zOGrlO1Zv/OWuA0RuK1oyuKoF5T57LIABqAiqc9OEQSoe
        PME+8OZt/NlOGOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE7691346F;
        Fri,  4 Nov 2022 21:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Age5K5iFZWPxCAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 04 Nov 2022 21:35:20 +0000
Date:   Fri, 4 Nov 2022 22:35:19 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5 02/17] log and reset 'errno' after
 failure to open non-critical files
Message-ID: <Y2WFl9YebQcbUuRe@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-3-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103183904.103562-3-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
