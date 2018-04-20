Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40965 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754612AbeDTLie (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 07:38:34 -0400
Date: Fri, 20 Apr 2018 13:36:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [LTP] [RFC PATCH v3 07/10] ima/ima_mmap: Reduce sleep + log it
Message-ID: <20180420113646.GC19090@rei>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-8-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419195503.7194-8-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi!
Proper synchronization between the processes wouldn't harm here.

FIY: we do have checkpoints for the shell library that can be used both
     from C sources as well as shell.

But given how big this patchset is at this point, it can wait for v2 I
guess.

-- 
Cyril Hrubis
chrubis@suse.cz
