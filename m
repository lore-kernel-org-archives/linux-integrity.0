Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38357 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754549AbeDTLEh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 07:04:37 -0400
Date: Fri, 20 Apr 2018 13:02:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [LTP] [RFC PATCH v3 05/10] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 1MB
Message-ID: <20180420110248.GB19090@rei>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419195503.7194-6-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi!
> +	event.data = (char *) malloc(MAX_EVENT_DATA_SIZE);
                        ^
		Please never cast return value from malloc() in	C.

The malloc returns void* which is compatible with any other pointer type
for assigments. This is only needed when you attempt to use malloc()
in C++, but that is not the case here.

-- 
Cyril Hrubis
chrubis@suse.cz
