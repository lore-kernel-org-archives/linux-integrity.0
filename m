Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F42C433FE
	for <linux-integrity@archiver.kernel.org>; Fri,  4 Nov 2022 21:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDVf6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKDVf5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 17:35:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F745EC1
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 14:35:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 784DF1F45F;
        Fri,  4 Nov 2022 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667597755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAeFLLt4nSPuZ6kUn8MV6pO4VLRGm8XlSy9ravtxnJU=;
        b=qBvfWZinkqA3QYS5GhpryNFZMCgXaQ2rL5eUJ4stXI1bk8uA0uzMEJnxllZtkxmE9B8/8x
        gvHI8Itwzn0Xl29uGURgZtRMWIkAfOppGrfKN3JNK2wWgihSjRWDBzQY3peVmKQpGsftxK
        EvY961QYeBKkpfCXav7uA+fjnjXTC2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667597755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAeFLLt4nSPuZ6kUn8MV6pO4VLRGm8XlSy9ravtxnJU=;
        b=iE4j7Q8ey/bA3gL87GsHQIjAmBeWO5S3eoUVPtzLh8pr36o7nc1r66Syzudr+IgnsAEIs9
        2YknvHiYxMeh9MDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41A761346F;
        Fri,  4 Nov 2022 21:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z4B3DruFZWNHCQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 04 Nov 2022 21:35:55 +0000
Date:   Fri, 4 Nov 2022 22:35:53 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Message-ID: <Y2WFuRNnP7qDLF4/@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-2-zohar@linux.ibm.com>
 <Y2WFHyiUgmSEbC1L@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WFHyiUgmSEbC1L@pevik>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Hi Mimi,

> > This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
> I remember there was some discussion about it, but it'd be nice to wrote the
> result for the revert (e.g. will be fixed properly in next commit).

> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Actually, I meant to use my work address:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr
