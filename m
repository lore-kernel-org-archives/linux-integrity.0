Return-Path: <SRS0=6Z2D=4N=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F090C35E01
	for <linux-integrity@archiver.kernel.org>; Tue, 25 Feb 2020 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA12082F
	for <linux-integrity@archiver.kernel.org>; Tue, 25 Feb 2020 16:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgBYQy4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:54:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:24697 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYQy4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 11:54:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 08:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="436320924"
Received: from gbwalsh-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.26.72])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2020 08:54:53 -0800
Date:   Tue, 25 Feb 2020 18:54:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] tpm: of: Handle IBM,vtpm20 case when getting log
 parameters
Message-ID: <20200225165452.GC15662@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
 <20200213202329.898607-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213202329.898607-2-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 03:23:26PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> A vTPM 2.0 is identified by 'IBM,vtpm20' in the 'compatible' node in
> the device tree. Handle it in the same way as 'IBM,vtpm'.
> 
> The vTPM 2.0's log is written in little endian format so that for this
> aspect we can rely on existing code.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
